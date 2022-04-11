import { useState, useEffect } from "react";
import Paper from "@mui/material/Paper";
import axios from "axios";
import moment from "moment";

import { url } from "../api";
// material
import {
  Card,
  Table,
  Stack,
  Button,
  TableRow,
  TableBody,
  TableCell,
  Container,
  Typography,
  TableContainer,
  TablePagination,
  TableHead,
  Alert,
  Collapse,
} from "@mui/material";
// components
import Page from "../components/Page";
import Scrollbar from "../components/Scrollbar";
import { Box } from "@mui/system";

export default function User() {
  const [page, setPage] = useState(0);
  const [alert, setAlert] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [rows, setRows] = useState([]);
  const [open, setOpen] = useState(true);

  const getAllUser = async () => {
    axios.get(url + "/admin/user")
        .then(r=>{
          setRows(r.data.data)
        })
        .catch(e=>setAlert(-1))
  }

  useEffect(async () => {
    await getAllUser()
  }, []);

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };
  const emptyRows =
    rowsPerPage - Math.min(rowsPerPage, rows.length - page * rowsPerPage);

  return (
    <Page title="Top Up | Cakrawala.id Admin">
      <Container>
        <Stack
          direction="row"
          alignItems="center"
          justifyContent="space-between"
          mb={5}
        >
          <Typography variant="h4" gutterBottom>
            User
          </Typography>
        </Stack>

        <Card>
          <Scrollbar>
            <TableContainer component={Paper}>
              <Table aria-label="simple table">
                <TableHead>
                  <TableRow>
                    <TableCell align="center">ID User</TableCell>
                    <TableCell align="center">Nama</TableCell>
                    <TableCell align="center">Email</TableCell>
                    <TableCell align="center">Saldo</TableCell>
                    <TableCell align="center">EXP</TableCell>
                    <TableCell align="center">Points</TableCell>
                    <TableCell align="center">Tanggal Daftar</TableCell>
                    <TableCell align="center">Action</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {rows.length <= 0 ? (
                    <TableCell colSpan={8} align="center">
                      Tidak ada user
                    </TableCell>
                  ) : (
                    rows
                      .slice(
                        page * rowsPerPage,
                        page * rowsPerPage + rowsPerPage
                      )
                      .map((row, index) => (
                        <TableRow key={row?.id}>
                          <TableCell align="center">{row?.id}</TableCell>
                          <TableCell align="center">{row?.Name}</TableCell>
                          <TableCell align="center">
                            {row?.email}
                          </TableCell>
                          <TableCell align="center">{row?.balance}</TableCell>
                          <TableCell align="center">{row?.exp}</TableCell>
                          <TableCell align="center">{row?.point}</TableCell>
                          <TableCell align="center">
                            {moment(row?.createdAt).format(
                              "MMMM Do YYYY, HH:mm:ss"
                            )}
                          </TableCell>
                          <TableCell align="center">
                            <Button
                                variant="outlined"
                                style={{
                                  borderColor: "#00A2ED",
                                  color: "#00A2ED",
                                  marginRight: "4px"
                                }}
                                onClick={() => {}}
                            >
                              Details
                            </Button>
                            <Button
                                variant="outlined"
                                style={{
                                  borderColor: "#b50531",
                                  color: "#b50531",
                                }}
                                onClick={() => {}}
                            >
                              Delete
                            </Button>
                          </TableCell>
                        </TableRow>
                      ))
                  )}
                  {emptyRows > 0 && (
                    <TableRow style={{ height: 53 * emptyRows }}>
                      <TableCell colSpan={6} />
                    </TableRow>
                  )}
                </TableBody>
              </Table>
              <TablePagination
                rowsPerPageOptions={[5, 10, 25]}
                component="div"
                count={rows.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onChangePage={handleChangePage}
                onChangeRowsPerPage={handleChangeRowsPerPage}
              />
            </TableContainer>
          </Scrollbar>
        </Card>
        <Box sx={{ mt: 3 }}>
          <Collapse in={open}>
            {alert === 1 ? (
              <Alert
                severity="success"
                color="info"
                onClose={() => {
                  setOpen(false);
                  setAlert(0);
                }}
              >
                Top Up Approved
              </Alert>
            ) : alert === -1 ? (
              <Alert
                severity="error"
                onClose={() => {
                  setOpen(false);
                  setAlert(0);
                }}
              >
                Top Up Approval Failed
              </Alert>
            ) : (
              <></>
            )}
          </Collapse>
        </Box>
      </Container>
    </Page>
  );
}
